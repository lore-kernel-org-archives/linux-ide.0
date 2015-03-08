From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] SATA: OCTEON: support SATA on OCTEON platform
Date: Sun, 08 Mar 2015 23:48:21 +0100
Message-ID: <2264145.MknHxHLvY7@wuerfel>
References: <1425567540-31572-1-git-send-email-aleksey.makarov@auriga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1425567540-31572-1-git-send-email-aleksey.makarov@auriga.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Aleksey Makarov <aleksey.makarov@auriga.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>, Vinita Gupta <vgupta@caviumnetworks.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 05 March 2015 17:58:58 Aleksey Makarov wrote:
> +       ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +       if (ret)
> +               return ret;
> 

Don't do this, instead you should set the dma-ranges of the parent
bus correctly so that dma_set_mask_and_coherent succeeds.

dma_coerce_mask_and_coherent() was introduced as a hack to
annotate broken drivers that were overriding the dma_mask pointer
themselves.

	Arnd
