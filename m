From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2] STi: Add ports-implemented property support
Date: Wed, 10 Aug 2016 12:24:42 -0400
Message-ID: <20160810162442.GM25053@mtj.duckdns.org>
References: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: patrice.chotard@st.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-ide@vger.kernel.org

On Wed, Aug 10, 2016 at 05:37:28PM +0200, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Despite ST AHCI version = 1.3, reading HOST_PORTS_IMPL
> returns 0. So force HOST_PORTS_IMPL to 1 by using
> ports-implemented DT property.
> Update achci_st driver and STi dts accordingly

Applied to libata/for-4.9.

Thanks.

-- 
tejun
