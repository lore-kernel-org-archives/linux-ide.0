From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: Only output sg element mapped number in verbose
 debug
Date: Thu, 12 Jul 2018 13:06:33 -0700
Message-ID: <20180712200633.GM72677@devbig577.frc2.facebook.com>
References: <5474a38b-c0d7-a7f7-6447-5720f40aafbe@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5474a38b-c0d7-a7f7-6447-5720f40aafbe@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Jul 12, 2018 at 06:31:03PM +0200, Paul Menzel wrote:
> Date: Sun, 8 Jul 2018 09:18:21 +0200
> 
> Defining `ATA_DEBUG` there are a lof of messages like below in the log.
> 
>     [   16.345472] ata_sg_setup: 1 sg elements mapped
> 
> As that is too verbose, only output these messages in verbose debug.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied to libata/for-4.19.  Thanks.

-- 
tejun
