From: Michael Schierl <schierlm-usenet@gmx.de>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against stable kernel
Date: Tue, 16 May 2006 16:42:18 +0200
Message-ID: <e4coc8$onk$1@sea.gmane.org>
References: <20060512132437.GB4219@htj.dyndns.org>
Reply-To: schierlm@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751175AbWEPOzG@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, 12 May 2006 22:24:37 +0900, Tejun Heo wrote:

> ahci:		new EH, irq-pio, NCQ, hotplug

Should suspend-to-RAM work now on AHCI? It produces lots of messages now
but does not work either now.

# ls
ata1.00: exception Emask 0x10 SAct 0x1 SEra 0x4050000 action 0x3 frozen
ata1.00 tag 0 cmd 0x60 Emask 0x14 stat 0x40 err 0x0 (ATA bus error)
ata1: soft resetting port
ata1: softreset failed (1st FIS failed)
ata1: softreset failed, retrying in 5 secs
ata1: hard resettinq port
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: COMRESET failed (device not ready)
ata1: hardreset failed, retrying in 5 secs
ata1: hard resettinq port
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: COMRESET failed (device not ready)
ata1: reset failed, giving up
ata1.00: disabled
ata1: EH complete
sd 0:0:0:0: SCSI error: return code = 0x40000
...

It produces lots of more SCSI errors (I did not want to write all those
down...) but no ata1-errors any more.

Michael
