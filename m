From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 12/14] ata: pata_octeon_cf: Use I/O clock rate for timing
 calculations.
Date: Mon, 11 Oct 2010 14:43:54 +0100
Message-ID: <20101011134354.GI30695@linux-mips.org>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
 <1286492633-26885-13-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1286492633-26885-13-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mips@linux-mips.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Oct 07, 2010 at 04:03:51PM -0700, David Daney wrote:

> The creation of the I/O clock domain requires some adjustments.  Since
> the CF bus timing logic is clocked by the I/O clock, use its rate for
> delay calculations.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: linux-ide@vger.kernel.org

Haven't seen any ack yet but I assume due to the dependencies on other
MIPS patches it'll be ok if I merge this through the MIPS tree, so I
queued it for 2.6.37.

Thanks!

  Ralf
