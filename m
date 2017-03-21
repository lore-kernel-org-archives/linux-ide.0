From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/3] ATA/ARM: convert ARM/DaVinci to use libata PATA
 drivers
Date: Tue, 21 Mar 2017 12:56:50 -0400
Message-ID: <20170321165650.GA3706@htj.duckdns.org>
References: <CGME20170314163738epcas5p3db719229d59550476c918a15d8c16d63@epcas5p3.samsung.com>
 <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
 <20170316213255.GF1480@htj.duckdns.org>
 <3c115ec1-2d11-695e-eca7-25a75f71b96f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3c115ec1-2d11-695e-eca7-25a75f71b96f@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Mar 21, 2017 at 02:08:26PM +0530, Sekhar Nori wrote:
> > Looks fine to me from libata side.  Once it gets tested, how should
> > the patches be routed?  I don't think it'd make sense to route them
> > separately.
> 
> Hi Tejun, I can take the series through ARM-SoC tree with your ack.

Once the review points are addressed, please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

and route through the arm tree.

Thanks.

-- 
tejun
