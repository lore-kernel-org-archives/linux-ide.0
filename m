From: Tejun Heo <tj@kernel.org>
Subject: Re: support for drives larger than 2TiB
Date: Sun, 25 Jul 2010 10:20:18 +0200
Message-ID: <4C4BF3C2.1020009@kernel.org>
References: <4C4AB952.9030705@kernel.org> <SNT125-W4469FAC3FE110BB4882949C3A40@phx.gbl> <4C4BEF61.5010203@kernel.org> <4C4BF0D2.1070503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C4BF0D2.1070503@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yuhong Bao <yuhongbao_386@hotmail.com>, jeff@garzik.org, ben.collins@ubuntu.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, hmh@debian.org
List-Id: linux-ide@vger.kernel.org

Hello,

On 07/25/2010 10:07 AM, H. Peter Anvin wrote:
> Syslinux 4 supports it with full 64-bit capabilities.  SeaBIOS (used in
> Qemu/KVM) supports it, and I know at least some hardware/firmware RAID
> solutions support it; I recently got access to a 3 TB SATA drive but due
> to NDA requirements I can't reveal the results of that testing.

Hmmm... doesn't sound too bad then.  Is there an easy to test whether
64bit LBA works?  I have a 2.5TiB drive and can test the machines I
have and probably publish the result too.

Thanks.

-- 
tejun
