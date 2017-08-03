From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] potential out of bounds in IDE
Date: Thu, 3 Aug 2017 17:48:15 +0300
Message-ID: <20170803144815.lcn6ihxrzs5sfnk5@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:51009 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbdHCOsd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Aug 2017 10:48:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-ide@vger.kernel.org

Hi Borislav,

I was reviewing a static checker warning:

	drivers/ide/ide-cd_ioctl.c:346 ide_cd_get_toc_entry()
	warn: buffer overflow 'toc->ent' 100 <= 255

drivers/ide/ide-cd_ioctl.c
   322  static int ide_cd_get_toc_entry(ide_drive_t *drive, int track,
   323                                  struct atapi_toc_entry **ent)
   324  {
   325          struct cdrom_info *info = drive->driver_data;
   326          struct atapi_toc *toc = info->toc;
   327          int ntracks;
   328  
   329          /*
   330           * don't serve cached data, if the toc isn't valid
   331           */
   332          if ((drive->atapi_flags & IDE_AFLAG_TOC_VALID) == 0)
   333                  return -EINVAL;
   334  
   335          /* Check validity of requested track number. */
   336          ntracks = toc->hdr.last_track - toc->hdr.first_track + 1;
   337  
   338          if (toc->hdr.first_track == CDROM_LEADOUT)
   339                  ntracks = 0;
   340  
   341          if (track == CDROM_LEADOUT)
   342                  *ent = &toc->ent[ntracks];
   343          else if (track < toc->hdr.first_track || track > toc->hdr.last_track)
   344                  return -EINVAL;
   345          else
   346                  *ent = &toc->ent[track - toc->hdr.first_track];
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
->ent[] has 100 elements but we can't gaurantee that
"toc->hdr.last_track - toc->hdr.first_track" is is in 0-99 range.

   347  
   348          return 0;
   349  }

The ->first_track and ->last_track variables are set in ide_cd_read_toc()
from drivers/ide/ide-cd.c:


  1017  
  1018          if (drive->atapi_flags & IDE_AFLAG_TOCTRACKS_AS_BCD) {
  1019                  toc->hdr.first_track = bcd2bin(toc->hdr.first_track);
  1020                  toc->hdr.last_track  = bcd2bin(toc->hdr.last_track);
  1021          }
  1022  
  1023          ntracks = toc->hdr.last_track - toc->hdr.first_track + 1;
  1024          if (ntracks <= 0)
  1025                  return -EIO;
  1026          if (ntracks > MAX_TRACKS)
                    ^^^^^^^^^^^^^^^^^^^^
This check implies that we can go over, but we leave the ->last_track as
is and continue.

  1027                  ntracks = MAX_TRACKS;
  1028  
  1029          /* now read the whole schmeer */
  1030          stat = cdrom_read_tocentry(drive, toc->hdr.first_track, 1, 0,
  1031                                    (char *)&toc->hdr,
  1032                                     sizeof(struct atapi_toc_header) +
  1033                                     (ntracks + 1) *
  1034                                     sizeof(struct atapi_toc_entry), sense);
  1035  

regards,
dan carpenter
