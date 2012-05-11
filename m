From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] ata_generic: Skip is_intel_ider() check when
 ata_generic=1 is set
Date: Fri, 11 May 2012 17:56:48 +0100
Message-ID: <20120511175648.19f2eaa5@bob.linux.org.uk>
References: <1336754003-31487-1-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336754003-31487-1-git-send-email-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

On Fri, 11 May 2012 09:33:23 -0700
Andi Kleen <andi@firstfloor.org> wrote:

> From: Andi Kleen <ak@linux.intel.com>
> 
> When ata_generic_ide=1 is set don't do the is_intel_ider() magic
> check. We found at least one box who needed that.
> 
> Cc: alan@linux.intel.com
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Alan Cox <alan@linux.intel.com>
