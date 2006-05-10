From: Tejun Heo <htejun@gmail.com>
Subject: Re: IRQ problem with sata_sil
Date: Wed, 10 May 2006 13:36:48 +0900
Message-ID: <44616DE0.3020008@gmail.com>
References: <e3n4ru$ktd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:49317 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964804AbWEJEgx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 00:36:53 -0400
Received: by py-out-1112.google.com with SMTP id f28so1809458pyf
        for <linux-ide@vger.kernel.org>; Tue, 09 May 2006 21:36:52 -0700 (PDT)
In-Reply-To: <e3n4ru$ktd$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas STRANSKY <Nico@stransky.cx>
Cc: linux-ide@vger.kernel.org

Nicolas STRANSKY wrote:
> Hi all,
> 
> I've encountered a problem when trying to use a SATA card with a Silicon
> Image SIL 3112 host controller chip. When inserting the module, the
> kernel made this error:
> 

Hello, Nicolas.

One of the most annoying problem with traditional IDE interface is that 
the controller doesn't have 'hey! I'm the needy one!' flag.  So, when an 
IRQ is raised, there is no way whether the controller is actually 
raising the interrupt or not.  libata (and probably other IDE drivers 
too) works around this by determining when to expect interrupt and 
handle the interrupt according to HSM.

Under normal circumstances, this usually works, but every now and then 
something weird happens and the controller raises IRQ that libata wasn't 
expecting, resulting in stuck IRQ and Linux IRQ layer saves its ass by 
disabling the IRQ, which is a good thing; otherwise, the whole system 
would hang completely.

In your case, the IRQ was in raised state before you loaded the module. 
  While loading the module, IRQ gets unmasked.  As libata hasn't issued 
any command yet, it isn't expecting interrupts, so it thinks the 
interrupt doesn't belong to it.  So, the stuck IRQ and your symptom.

libata is in the way of getting new EH/probing mechanism and the problem 
will be resolved.  New EH/probing does two things to prevent such things.

* freeze (mask interrupt) the port before requesting IRQ and thaw 
(unmask) only after the controller and drives are reset and in known 
good state.

* sil3112 family of controllers (and most of other modern SATA 
controllers too) actually have the needy flag.  New version of sata_sil 
will have customized IRQ handler which properly detects and handles 
unexpected/spurious interrupts.

New EH/probing will probably included in 2.6.18 but I intend to make 
patches against stable series.  So, if this problem bugs you, stay tuned.

-- 
tejun
