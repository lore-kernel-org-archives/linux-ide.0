From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3 v2] ahci: qoriq: added a condition to enable dma
 coherence
Date: Fri, 20 Jan 2017 08:34:29 -0500
Message-ID: <20170120133429.GB31487@mtj.duckdns.org>
References: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, robh+dt@kernel.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Fri, Jan 20, 2017 at 02:59:34PM +0800, yuantian.tang@nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> Enable DMA coherence in SATA controller on condition that
> dma-coherent property exists in sata node in DTS.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
