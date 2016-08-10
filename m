From: <patrice.chotard@st.com>
Subject: [PATCH 0/2] STi: Add ports-implemented property support
Date: Wed, 10 Aug 2016 17:37:28 +0200
Message-ID: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
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
To: Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: patrice.chotard@st.com, kernel@stlinux.com
List-Id: linux-ide@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Despite ST AHCI version = 1.3, reading HOST_PORTS_IMPL
returns 0. So force HOST_PORTS_IMPL to 1 by using
ports-implemented DT property.
Update achci_st driver and STi dts accordingly

Patrice Chotard (2):
  ahci: st: Add ports-implemented property in support
  ARM: dts: STiH407-family: Add ports-implemented property in sata nodes

 arch/arm/boot/dts/stih407-family.dtsi | 4 ++++
 drivers/ata/ahci_st.c                 | 4 ++++
 2 files changed, 8 insertions(+)

-- 
1.9.1
