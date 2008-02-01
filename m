From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 5/9] libata: implement and use SHT initializers and ops
 inheritance
Date: Fri, 01 Feb 2008 15:49:40 -0500
Message-ID: <47A385E4.5000901@garzik.org>
References: <12016853433196-git-send-email-htejun@gmail.com> <12016853432907-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50430 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756147AbYBAUtn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 15:49:43 -0500
In-Reply-To: <12016853432907-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Tejun Heo wrote:
> libata lets low level drivers build scsi_host_template and
> ata_port_operations tables and register them with upper layers.  This
> allows low level drivers high level of flexibility but also burdens
> them with lots of boilerplate entries in thoes data structures.
> 
> This becomes worse for drivers which support related similar
> controllers which differ slightly.  They share most of the operations
> except for a few.  However, the driver still needs to list all
> operations for each variant.  This results in large number of
> duplicate entries, which is not only inefficient but also error-prone
> as it becomes very difficult to tell what the actual differences are.
> 
> This duplicate boilerplates all over the low level drivers also make
> updating the core layer exteremely difficult and error-prone.  When
> compounded with multi-branched development model, it ends up
> accumulating inconsistencies over time.  Some of those inconsistencies
> cause immediate problems and fixed.  Others just remain there dormant
> making maintenance increasingly difficult.
> 
> To rectify the problem, this patch implements SHT initializers and
> ata_port_operations inheritance.  SHT initializers can be used to
> initialize all the boilerplate entries in a sht.  Three variants of
> them exist - BASE, BMDMA and NCQ - for different types of drivers.
> Note that entries can be overriden by putting individual initializers
> after the helper macro.
> 
> Ops handling is a bit more involved to allow LLDs to easily re-use
> their own ops tables overriding only specific methods.  This is
> basically poor man's class inheritance.  An ops table has ->inherits
> field which can be set to any ops table as long as it doesn't create a
> loop.  When the host is started, the inheritance chain is followed and
> any operation which isn't specified is taken from the nearest ancestor
> which has it specified.  This operation is called finalization and
> done only once per an ops table and the LLD doesn't have to do
> anything special about it other than making the ops table non-const
> such that libata can update it.
> 
> libata provides four base ops tables lower drivers can inherit from -
> base, sata, pmp, sff and bmdma.  To avoid overriding these ops
> accidentaly, these ops are declared const and LLDs should always
> inherit these instead of using them directly.
> 
> After finalization, all the sht and ops table are identical before and
> after the patch except for setting .irq_handler to ata_interrupt in
> drivers which didn't use to.  The .irq_handler doesn't have any actual
> effect and the field will soon be removed by later patch.
> 
> * sata_sx4 is still using old style EH and currently doesn't take
>   advantage of ops inheritance.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Two comments:

1) Please split into SHT and ops patches (SHT first, I presume)

2) It seems like inheritance would be easier and less error-prone if the 
ops were copied, rather than modifying the structures in-place.  Comments?

