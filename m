From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
 for CF	interface
Date: Wed, 25 Jul 2007 21:54:07 +0400
Message-ID: <46A78E3F.1030904@ru.mvista.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>	<20070725165326.5331.19920.stgit@localhost.localdomain> <46A78322.3080607@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933822AbXGYRwU@vger.kernel.org>
In-Reply-To: <46A78322.3080607@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

Hello, I wrote:

>>diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
>>index db0d003..f8f0e8a 100644
>>--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
>>+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
>>@@ -37,6 +37,15 @@
>> 		reg = <00000000 10000000>;
>> 	};
>> 
>>+	ide@f0000000 {
>>+		compatible = "mmio-ide";
>>+		device_type = "ide";

>     Why not "ata"?

    Also, what mmio-ide in the compat properly means in the context of 
ide_platform which is able to handle both port and memory mapped IDE. I think 
we must get rid with this crap, and since this IDE register mapping is pretty 
much board specific, call it something like "mpc8349emitx-ide" instead.

MBR, Sergei
