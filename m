From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: ide: pmac: Convert to using %pOF instead of full_name
Date: Fri,  1 Sep 2017 23:29:48 +1000 (AEST)
Message-ID: <3xkKq05PPZz9t3k@ozlabs.org>
References: <20170718214339.7774-27-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718214339.7774-27-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 2017-07-18 at 21:43:07 UTC, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-ide@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Acked-by: David S. Miller <davem@davemloft.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/859420e3155d8192b31a93cd92d32c

cheers
