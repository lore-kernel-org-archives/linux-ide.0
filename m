From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA ACPI (was Re: Linux 2.6.24-rc4)
Date: Mon, 10 Dec 2007 17:42:16 +0900
Message-ID: <475CFBE8.7000203@gmail.com>
References: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org>	 <8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com>	 <4755C544.5060909@garzik.org> <4755C63B.7080608@garzik.org>	 <8db1092f0712041448t5a3da9ecna73730e421626450@mail.gmail.com>	 <4755DC07.5090009@garzik.org> <8db1092f0712042346m38182aafn953077c0c090bdad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:50053 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbXLJImZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 03:42:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1548450rvb
        for <linux-ide@vger.kernel.org>; Mon, 10 Dec 2007 00:42:25 -0800 (PST)
In-Reply-To: <8db1092f0712042346m38182aafn953077c0c090bdad@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Maciej Rutecki wrote:
> 2007/12/5, Jeff Garzik <jeff@garzik.org>:
> 
>> _If_ libata is built into the kernel, and not a kernel module, then you
>> can supply "libata.noacpi=1" on the kernel command line.  I don't think
>> that works with modules.

JFYI: fix for this and other ACPI issues is being tested.  Please take a
look at the following bug.

  http://bugzilla.kernel.org/show_bug.cgi?id=9320

-- 
tejun
