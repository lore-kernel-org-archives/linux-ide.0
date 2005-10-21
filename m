From: Werner Backes <wernerbackes@gmail.com>
Subject: Combined mode on Dell Inspiron 6000 - patch for 2.6.14-rc5 - ata_piix.c
Date: Fri, 21 Oct 2005 16:15:37 -0500
Message-ID: <200510211615.38029.wernerbackes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:26593 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965160AbVJUUMh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2005 16:12:37 -0400
Received: by zproxy.gmail.com with SMTP id i11so409043nzi
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2005 13:12:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

I'm no kernel expert at all, but since the combined mode for 2.6.13.x was 
working and for 2.6.14-rcx not, I looked at the differences in the code. I 
changed the following line in ata_piix.c. The original code is commented out. 
Since you only switched the values of both defines the line from 2.6.13.x 
seemed to make sense....
Without this change the drive is found, but I cannot use it. No mount, no 
burning, ...  
I hope this will help somehow ...

Werner Backes

static int piix_sata_probe (struct ata_port *ap)
{
  ....

        /* TODO: this is vaguely wrong for ICH6 combined mode,
         * where only two of the four SATA ports are mapped
         * onto a single ATA channel.  It is also vaguely inaccurate
         * for ICH5, which has only two ports.  However, this is ok,
         * as further device presence detection code will handle
         * any false positives produced here.
         */

        for (i = 0; i < 4; i++) {
                mask = (PIIX_PORT_PRESENT << i) | (PIIX_PORT_ENABLED << i);
/*              mask = (PIIX_PORT_ENABLED << i); */

                if ((orig_mask & mask) == mask)
                        if (combined || (i == ap->hard_port_no))
                                return 1;
        }



