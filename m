From: Erik Andersen <andersen@codepoet.org>
Subject: Re: [sata] Promise PATA port on PDC2037x SATA
Date: Thu, 25 Mar 2004 20:45:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040326034504.GA2043@codepoet.org>
References: <40638943.9010206@pobox.com> <20040326031619.GA1755@codepoet.org> <4063A64D.2000901@pobox.com>
Reply-To: andersen@codepoet.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4063A64D.2000901@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu Mar 25, 2004 at 10:41:01PM -0500, Jeff Garzik wrote:
> Thanks for testing.
> 
> Is your PCI id listed in this function?
> 
> static int pdc_pata_possible(struct pci_dev *pdev)
> {
>         if (pdev->device == 0x3375)
>                 return 1;
>         return 0;
> }
> 
> If yes, hrm.  :)

$ lspci -v | grep -A9 Promise
02:0c.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 3375 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 3375
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 20
        I/O ports at de80 [size=64]
        I/O ports at dfa0 [size=16]
        I/O ports at dc00 [size=128]
        Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
        Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at feab0000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 2

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
