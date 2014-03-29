From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Subject: ata: libata  Fixed Coding style & tabs
Date: Sat, 29 Mar 2014 09:10:42 -0400
Message-ID: <20140329131042.GA5553@htj.dyndns.org>
References: <5335B9BA.3070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5335B9BA.3070408@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmcquad <paulmcquad@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Paul.

On Fri, Mar 28, 2014 at 06:04:42PM +0000, paulmcquad wrote:
> From 718d05b6aae57da1a990e38b99a4e3d880717d77 Mon Sep 17 00:00:00 2001
> From: Paul McQuade <paulmcquad@gmail.com>
> Date: Fri, 28 Mar 2014 17:58:02 +0000
> Subject: [PATCH] Subject: ata: libata  Fixed Coding style & tabs
> 
> Made files below checkpatch.pl clean.

I don't think I'm gonna apply the patch.  This type of mass whitespace
cleanups tend to cause conflicts without making anything substantially
better.  I'd much prefer to localized style cleanups when code
close-by is being changed.  Big ones are fine if they're accompanied
by large actual changes too.

Thanks.

-- 
tejun
