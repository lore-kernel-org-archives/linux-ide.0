From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 02/12] iommu-helper: unexport iommu_area_alloc
Date: Mon, 16 Apr 2018 14:36:56 +0530
Message-ID: <1cedfc7e-9168-47bd-cc6a-0557b92eb37b@linux.vnet.ibm.com>
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180415145947.1248-3-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, iommu@lists.linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, x86@kernel.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> This function is only used by built-in code.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
