From: Fajun Chen <fajunchen@yahoo.com>
Subject: [RFC] sata_sil24 driver bugs?
Date: Fri, 28 Apr 2006 16:33:43 -0700 (PDT)
Message-ID: <20060428233343.28845.qmail@web54707.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web54707.mail.yahoo.com ([206.190.49.197]:25271 "HELO
	web54707.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932453AbWD1Xdo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Apr 2006 19:33:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Hi Folks,

I identified a potential bug in sata_sil24.c (Driver
version 0.23). I am running Linux 2.6.16 with Alan
Fox's libata patch.

In function sil24_tf_read(), LBA mode and protocol
fields in a command were reset inadvertently when
device register values are read from private data.
This impacts error handling since wrong LBAs/Sector
count can be reported. I am not sure if this can
impact other operations.

I've patched the code to read only register values
from
private data so 'flags', 'protocol' and 'ctl' fields
won't get reset. This seems to be working. 

Could you please provide information in regard to
whether this is a known problem and evaluate its
impact? Your feedback will be greatly appreciated.

Thanks,
Fajun

-----------------------------------------------------
Patched code:
static void sil24_tf_read(struct ata_port *ap, struct
ata_taskfile *tf)
{
        /* Only fields from SATA FIS need to be read
*/

        struct sil24_port_priv *pp = ap->private_data;

        tf->command   = pp->tf.command;  /* status */
        tf->feature   = pp->tf.feature;  /* error */

        tf->lbal      = pp->tf.lbal;
        tf->lbam      = pp->tf.lbam;
        tf->lbah      = pp->tf.lbah;
        tf->device    = pp->tf.device;

        tf->hob_lbal  = pp->tf.hob_lbal;
        tf->hob_lbam  = pp->tf.hob_lbam;
        tf->hob_lbah  = pp->tf.hob_lbah;

        tf->nsect     = pp->tf.nsect;
        tf->hob_nsect = pp->tf.hob_nsect;
}


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
