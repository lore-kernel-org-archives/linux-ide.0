From: Christoph Hellwig <hch@lst.de>
Subject: centralize SWIOTLB config symbol and misc other cleanups
Date: Sun, 15 Apr 2018 16:59:35 +0200
Message-ID: <20180415145947.1248-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, iommu@lists.linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, x86@kernel.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi all,

this seris aims for a single defintion of the Kconfig symbol.  To get
there various cleanups, mostly about config symbols are included as well.
