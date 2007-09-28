From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH][resend] PCI: fix IDE legacy mode resources
Date: Fri, 28 Sep 2007 06:23:48 -0400
Message-ID: <46FCD634.7070309@garzik.org>
References: <20070824115559.06250ec0.yoichi_yuasa@tripeaks.co.jp> <20070824161442.GB15305@kroah.com> <20070824173713.2bc20bac@the-village.bc.nu> <20070928084840.GA5542@derision.cyrius.com> <20070928111408.119f0631@the-village.bc.nu> <20070928101059.GA13826@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760636AbXI1KYQ@vger.kernel.org>
In-Reply-To: <20070928101059.GA13826@deprecation.cyrius.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, greg@kroah.com, akpm@osdl.org
List-Id: linux-ide@vger.kernel.org

Martin Michlmayr wrote:
> * Alan Cox <alan@lxorguk.ukuu.org.uk> [2007-09-28 11:14]:
>>> I need this patch for IDE and PATA to work on my MIPS Cobalt.
>>> Yoichi's original patch and explanation can be found at
>>> http://lkml.org/lkml/2007/8/23/411
>> I've no idea why it hasn't been applied unless nobody is quite sure who
>> owns it. As a PCI fix I guess Greg does (and drop it into -mm for
>> testing) ?
> 
> I was also hoping Jeff would comment on the patch.

What sort of comment were you seeking?  :)

	Jeff
