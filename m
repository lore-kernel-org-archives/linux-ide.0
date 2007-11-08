From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2 take #2] libata: Support PIO polling-only hosts.
Date: Thu, 8 Nov 2007 13:14:28 -0500
Message-ID: <20071108181428.GF3491@havoc.gtf.org>
References: <20071108021456.GA30648@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20071108021456.GA30648@linux-sh.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Paul Mundt <lethal@linux-sh.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxsh-dev@
List-Id: linux-ide@vger.kernel.org

On Thu, Nov 08, 2007 at 11:14:56AM +0900, Paul Mundt wrote:
> By default ata_host_activate() expects a valid IRQ in order to
> successfully register the host. This patch enables a special case
> for registering polling-only hosts that either don't have IRQs
> or have buggy IRQ generation (either in terms of handling or
> sensing), which otherwise work fine.
> 
> Hosts that want to use polling mode can simply set ATA_FLAG_PIO_POLLING
> and pass in an invalid IRQ.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 

applied 1-2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
