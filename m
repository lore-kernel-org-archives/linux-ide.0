From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: correct the sata ecc setting error
Date: Thu, 9 Mar 2017 11:56:47 -0500
Message-ID: <20170309165647.GB28982@htj.duckdns.org>
References: <1489050809-15265-1-git-send-email-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1489050809-15265-1-git-send-email-andy.tang@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yuantian Tang <andy.tang@nxp.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Thu, Mar 09, 2017 at 05:13:29PM +0800, Yuantian Tang wrote:
> Sata ecc is controlled by only 1 bit which is 24bit in big-endian
> in ecc register. So only setting 24bit to disable sata ecc prevents
> other bits from being overwritten in ecc register.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>

Applied to libata/for-4.11-fixes.

Thanks.

-- 
tejun
