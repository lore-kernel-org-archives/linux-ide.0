From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/3] IDE-ACPI: Fine-tuning for a function
Date: Sat, 26 Dec 2015 15:43:02 -0800
Message-ID: <1451173382.12498.10.camel@perches.com>
References: <566ABCD9.1060404@users.sourceforge.net>
	 <567E6799.5070802@users.sourceforge.net>
	 <20151226.131257.1589698540013987354.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151226.131257.1589698540013987354.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, elfring@users.sourceforge.net
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, julia.lawall@lip6.fr
List-Id: linux-ide@vger.kernel.org

On Sat, 2015-12-26 at 13:12 -0500, David Miller wrote:
> IDE is in deep freeze maintainence mode.
> 
> Therefore patches that perform simplications and cleanups will
> not be accepted.

Maybe there should be something like a README
in drivers/ide that says that.

Maybe the MAINTAINERS entry for "IDE SUBSYSTEM"
should be something like:

S:	Frozen - critical fixes only
