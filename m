From: "Stanislav Brabec" <sbrabec@novell.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP
	drive
Date: Tue, 13 Mar 2007 12:17:17 +0100
Message-ID: <45F6964D0200002D000156EC@emea5-mh.id5.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:40887 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933144AbXCMLto convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 07:49:44 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: bzolnier@gmail.com, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> > [libata]
> > And, as the device requires custom high level driver, libata fails
> > miserably.  Would it be worth to try support these devices?  Or are
> > they just too outdated to put the effort in?
> 
> What SCSI peripheral device type does it report, when booted under libata?

Internal IOMEGA ZIP 100 IDE (manufactured by NEC).

ata1.01: ATAPI, max PIO2, CDB intr
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
         res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1: soft resetting port
ata1.01: configured for PIO2
ata1: EH complete
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
         res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1.01: configured for PIO2
ata1: EH complete
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
         res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1: soft resetting port
... and so on

For more see
https://bugzilla.novell.com/show_bug.cgi?id=232086
(complete ide-floppy and libata logs are there)

-- 
Best Regards,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarska 1060/12                            tel: +420 284 028 966
190 00 Praha 9                                fax: +420 284 028 951
Czech Republic                                http://www.suse.cz/

