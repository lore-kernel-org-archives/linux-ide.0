From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ahci: use pci_alloc_irq_vectors
Date: Mon, 24 Oct 2016 21:21:54 +0200
Message-ID: <20161024192154.GA13769@lst.de>
References: <1473088905-27670-1-git-send-email-hch@lst.de>
 <1473088905-27670-2-git-send-email-hch@lst.de>
 <20160906163946.GB24268@htj.duckdns.org>
 <20161020154722.GH22012@rric.localdomain> <20161021125918.GA18082@lst.de>
 <20161021140106.GU25086@rric.localdomain> <20161022141123.GA25500@lst.de>
 <580E59AA.60107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <580E59AA.60107@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: Robert Richter <rric@kernel.org>, Auger Eric <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-ide@vger.kernel.org, Robert Richter <robert.richter@cavium.com>, dan.j.williamps@intel.com, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi David,

On Mon, Oct 24, 2016 at 11:57:46AM -0700, David Daney wrote:
>> If so can you try the patch below?
>
> I applied it to v4.9-rc1 (really commit 
> 6f33d6458e35d6ba53c2635ee4b8a3177cbd912d), and this didn't seem to make it 
> work.

Please try on top of the libata for-4.9-fixes branch:

https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.9-fixes
