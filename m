From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: added ls2088a platforms support
Date: Wed, 18 Jan 2017 11:21:05 -0800
Message-ID: <20170118192105.GB9171@mtj.duckdns.org>
References: <1484633521-10938-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484633521-10938-1-git-send-email-yuantian.tang@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: yuantian.tang@nxp.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jan 17, 2017 at 02:12:01PM +0800, yuantian.tang@nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> Ls2088a is new introduced arm-based soc with sata support with
> following features:
> 1. Complies with the serial ATA 3.0 specification and the AHCI 1.3.1
>    specification
> 2. Contains a high-speed descriptor-based DMA controller
> 3. Supports the following:
>    a. Speeds of 1.5 Gb/s (first-generation SATA), 3 Gb/s
>       (second-generation SATA), and 6 Gb/s (third-generation SATA)
>    b. FIS-based switching
>    c. Native command queuing (NCQ) commands
>    d. Port multiplier operation
>    e. Asynchronous notification
>    f. SATA BIST mode
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
