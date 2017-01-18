From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 09/13] sata: ahci: export ahci_do_hardreset() locally
Date: Wed, 18 Jan 2017 10:28:26 -0800
Message-ID: <20170118182826.GA1451@mtj.duckdns.org>
References: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
 <1484745601-4769-10-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484745601-4769-10-git-send-email-bgolaszewski@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hello, Bartosz.

On Wed, Jan 18, 2017 at 02:19:57PM +0100, Bartosz Golaszewski wrote:
> We need a way to retrieve the information about the online state of
> the link in the ahci-da850 driver.
> 
> Create a new function: ahci_do_hardreset() which is called from
> ahci_hardreset() for backwards compatibility, but has an additional
> argument: 'online' - which can be used to check if the link is online
> after this function returns.

Please just add @online to ahci_hardreset() and update the callers.
Other than that, the sata changes look good to me.

Thanks.

-- 
tejun
