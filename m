From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 1/3] ata: add Palmchip BK3710 PATA controller driver
Date: Tue, 21 Mar 2017 14:04:38 +0530
Message-ID: <8fc9171f-15b7-2c6a-d0b5-3af21cc88405@ti.com>
References: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170314163742epcas5p32a49df6b4ae6c21ee159c79320df5781@epcas5p3.samsung.com>
 <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi,

On Tuesday 14 March 2017 10:06 PM, Bartlomiej Zolnierkiewicz wrote:
> Add Palmchip BK3710 PATA controller driver.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

There are some checkpatch suggestions that are worth fixing, I think.

[PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:277: CHECK: Alignment should match open parenthesis
[PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:320: CHECK: Alignment should match open parenthesis
[PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:489: CHECK: Comparison to NULL could be written "!mem"

Thanks,
Sekhar
