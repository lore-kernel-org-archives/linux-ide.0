From: Tejun Heo <tj@kernel.org>
Subject: Re: qc timeout ... failed to IDENTIFY - qemu/kvm setup
Date: Tue, 17 Aug 2010 18:15:02 +0200
Message-ID: <4C6AB586.6090807@kernel.org>
References: <AANLkTikAAAGg-OO81my14YAkQP-wK86rmXVhAiqAWf1i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34966 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306Ab0HQQTB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2010 12:19:01 -0400
In-Reply-To: <AANLkTikAAAGg-OO81my14YAkQP-wK86rmXVhAiqAWf1i@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tharindu Rukshan Bamunuarachchi <btharindu@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 08/09/2010 07:55 PM, Tharindu Rukshan Bamunuarachchi wrote:
> hi All,
> 
> I am getting following message when I try to start my qemu/kvm virtual machine.
> I have been using qemu/kvm setup for last couple of months, issue was
> introduced after upgrading to v2.6.35-rc6.
> 
> VM starts as usual when I disable SMP. Issue is not visible in v2.6.34x.
> 
> [    6.052229] ata1.01: qc timeout (cmd 0xec)
> [    6.054105] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> [    6.056653] ata2.01: qc timeout (cmd 0xec)
> [    6.058453] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   16.212186] ata1.01: qc timeout (cmd 0xec)
> [   16.214056] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   16.220146] ata2.01: qc timeout (cmd 0xec)
> [   16.221986] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   46.376202] ata1.01: qc timeout (cmd 0xec)
> [   46.378164] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   46.384165] ata2.01: qc timeout (cmd 0xec)
> [   46.386140] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> 
> I think following CONFIGs are introduced with latest version ... could
> there be any relation to above error ..
> 
> CONFIG_IO_DELAY_TYPE_0X80=0
> CONFIG_IO_DELAY_TYPE_0XED=1
> CONFIG_IO_DELAY_TYPE_UDELAY=2
> CONFIG_IO_DELAY_TYPE_NONE=3
> CONFIG_IO_DELAY_0X80=y
> 
> 
> Please provide any clue or debug method to resolve the issue ?
> Could this be an issue with kvm/qemu ?
> 
> Sorry if i am addressing wrong mailing-list.

If the problem is qemu specific, it would probably be bettr to report
it to qemu mailing list.  Can you please post full kernel log just in
case?

Thanks.

-- 
tejun
