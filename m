From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hwif->rw_disk() method
Date: Thu, 11 Jan 2007 16:38:55 +0300
Message-ID: <45A63DEF.3010604@ru.mvista.com>
References: <45A514AB.2080605@ru.mvista.com> <20070110171015.5320fa17@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:23933 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030440AbXAKNix (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jan 2007 08:38:53 -0500
In-Reply-To: <20070110171015.5320fa17@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Hello.

Alan wrote:

>>    Alan/Bart/anybody, could you enlighten me why hwif->rw_disk() method came 
>>into being at all?

> When you needed to wrap entire disk operations. The ->dma_ methods only
> wrap DMA commands.

    BTW, I've looked at the clock turnaround code both in drivers/ide/hpt366.c 
and drivers/ata/pata_hpt3x2n.c and compared it to the HighPoint driver and I'm 
dazed and confused (again?):  contrary to what HighPoint does (I'm not sure 
they're still doing it at all due to confused nature of their drivers :-), 
Linux uses DPLL on reads and PCI clock on writes.  The libata driver seem to 
have an explicit contradiction:

static int hpt3x2n_use_dpll(struct ata_port *ap, int reading)
{
         long flags = (long)ap->host->private_data;
         /* See if we should use the DPLL */
         if (reading == 0)
                 return USE_DPLL;        /* Needed for write */
         if (flags & PCI66)
                 return USE_DPLL;        /* Needed at 66Mhz */
         return 0;
}

static unsigned int hpt3x2n_qc_issue_prot(struct ata_queued_cmd *qc)
{
         struct ata_taskfile *tf = &qc->tf;
         struct ata_port *ap = qc->ap;
         int flags = (long)ap->host->private_data;

         if (hpt3x2n_pair_idle(ap)) {
                 int dpll = hpt3x2n_use_dpll(ap, (tf->flags & ATA_TFLAG_WRITE));
                 if ((flags & USE_DPLL) != dpll) {
                         if (dpll == 1)
                                 hpt3x2n_set_clock(ap, 0x21);
                         else
                                 hpt3x2n_set_clock(ap, 0x23);
                 }
         }
         return ata_qc_issue_prot(qc);
}

    ATA_TFLAG_WRITE indicates a write transfer (host-to-device) while 
hpt3x2n_use_dpll() contrarywise expects the read transfer indication. Comments?

WBR, Sergei
