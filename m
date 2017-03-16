From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] pata: remove the at91 driver
Date: Thu, 16 Mar 2017 17:11:21 -0400
Message-ID: <20170316211121.GA1480@htj.duckdns.org>
References: <1489585151-16415-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1489585151-16415-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 15, 2017 at 02:39:11PM +0100, Boris Brezillon wrote:
> This driver is orphan since commit b2026f708e09 ("ARM: at91: remove
> at91sam9260/at91sam9g20 legacy board support"). Given that nobody cared
> adding DT support to it, it probably means it's no longer used and is
> thus a good candidate for removal.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to libata/for-4.12.

Thanks.

-- 
tejun
