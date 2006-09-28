From: Jim Paris <jim@jtan.com>
Subject: Re: [PATCH] libata: lengthen interval between SRST set and clear
Date: Thu, 28 Sep 2006 02:23:57 -0400
Message-ID: <20060928062357.GA12266@jim.sh>
References: <20060927082005.GA14569@jim.sh> <20060928051415.GG25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:12492 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S1161032AbWI1GYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 02:24:08 -0400
Content-Disposition: inline
In-Reply-To: <20060928051415.GG25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mail@philipp-wagner.com, linux-ide@vger.kernel.org, jeff@garzik.org

Hi Tejun,

> 20us isn't enough for some SATA controllers (sata_nv) ending up not
> sending the second FIS27 to clear SRST.  This usually results in SRST
> timeout causing excessive delays during hotplug.
>
> This patch lengthens the delay from 20us to 1ms and also converts it
> to msleep() instead of busy wait.

Thanks for the patch.  Unfortunately it doesn't seem to help on 2.6.18:

Unplug:
[  190.559849] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1810000 action 0x2 frozen
[  191.274576] ata3: soft resetting port
[  191.274580] ata3: SATA link down (SStatus 0 SControl 300)
[  191.274585] ata3: failed to recover some devices, retrying in 5 secs
[  196.276276] ata3: hard resetting port
[  196.999941] ata3: SATA link down (SStatus 0 SControl 300)
[  196.999947] ata3: failed to recover some devices, retrying in 5 secs
[  202.001639] ata3: hard resetting port
[  202.725303] ata3: SATA link down (SStatus 0 SControl 300)
[  202.725309] ata3.00: disabled
[  203.229080] ata3: EH complete
[  203.229091] ata3.00: detaching (SCSI 2:0:0:0)

Replug:
[  222.501022] ata3: exception Emask 0x10 SAct 0x0 SErr 0x150000 action 0x2 frozen
[  230.220666] ata3: port is slow to respond, please be patient
[  253.226040] ata3: port failed to respond (30 secs)
[  253.226090] ata3: soft resetting port
[  260.398768] ata3: port is slow to respond, please be patient
[  283.404138] ata3: port failed to respond (30 secs)
[  283.404195] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  283.404203] ata3: EH complete

and the disk never comes back.  This is just like my earlier log from
vanilla 2.6.18 (except SErr differs by 0x100000).

-jim
