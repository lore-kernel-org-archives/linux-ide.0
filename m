From: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 4/4] ata: add new-style AHCI platform driver for ST
 SPEAr1340 AHCI controller
Date: Thu, 20 Mar 2014 14:27:17 +0530
Message-ID: <20140320085717.GC4607@pratyush-vbox>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
 <1395081118-15248-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1395081118-15248-5-git-send-email-b.zolnierkie@samsung.com>
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
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, spear-devel <spear-devel@list.st.com>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@deeprootsystems.com>, Mohit Kumar <mohit.kumar@st.com>, Shiraz Hashim <shiraz.hashim@gmail.com>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 18, 2014 at 02:31:58AM +0800, Bartlomiej Zolnierkiewicz wrote:
> The new driver is named ahci_spear1340 and is only compile tested.  Once
> it is tested on the real hardware and verified to work correctly, the legacy
> platform code (which depends on the deprecated struct ahci_platform_data)
> can be removed.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This patch will not be needed any more, since SPEAr sata platform code has
already been cleaned up.

See:
https://lkml.org/lkml/2014/2/28/174

Regards
Pratyush
