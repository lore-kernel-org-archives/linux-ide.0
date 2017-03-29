From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 0/5] ATA/ARM: convert ARM/DaVinci to use libata PATA
 drivers
Date: Wed, 29 Mar 2017 11:35:52 -0400
Message-ID: <20170329153552.GC30385@htj.duckdns.org>
References: <CGME20170322182127epcas1p267b13e8c92205223458863783bdea476@epcas1p2.samsung.com>
 <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <aaf669ba-4439-9af7-7943-c9163bd99020@ti.com>
 <7423344.GzQhW9fIvG@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <7423344.GzQhW9fIvG@amdc3058>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Russell King <linux@arm.linux.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Fri, Mar 24, 2017 at 04:38:24PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Thursday, March 23, 2017 07:27:05 PM Sekhar Nori wrote:
> > On Wednesday 22 March 2017 11:50 PM, Bartlomiej Zolnierkiewicz wrote:
> > > Hi,
> > > 
> > > This patchset adds Palmchip BK3710 IDE controller driver to
> > > libata and switches ARM/DaVinci to use it (instead of the old
> > > IDE driver).
> > > 
> > > Sekhar, please check that it still works after changes, thanks.
> > 
> > Did some basic mount/read/write tests, it passed.
> 
> Thanks for checking.
> 
> I guess that you can merge the patchset now to your tree
> (with Tejun's ACK for the whole patches and Sergei's ACK
> for ATA changes).

Acked-by: Tejun Heo <tj@kernel.org>

Yeah, please feel free to route the series as you see fit.

Thanks.

-- 
tejun
