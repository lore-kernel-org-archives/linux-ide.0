From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: ide: Use of_node_name_eq for node name comparisons
Date: Mon, 24 Dec 2018 00:27:59 +1100 (AEDT)
Message-ID: <43N38H60Jxz9sNC@ozlabs.org>
References: <20181205195050.4759-9-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205195050.4759-9-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-ide@vger.kernel.org

On Wed, 2018-12-05 at 19:50:25 UTC, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-ide@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c1fa31b0fc90a80d64a334e5d35dca

cheers
