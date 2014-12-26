From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: (unknown)
Date: Fri, 26 Dec 2014 18:26:37 +0100
Message-ID: <1419614799-5770-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Subject: 
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

Subject: [PATCH 0/2] regulator: Add the device tree version to the regulator_get family

Hi,

Currently it is not possible to associate a regulator to a child node
which is not a device. The several ports of an ahci controller are
represented as subnodes but they are not created as devices. In order
to be able to associate each port with a regulator the framework API
needs to be extended.

The second patch adds the device tree version (of_) for each member of
the regulator_get family: normal, exclusive, optional and all of the
manageable version.The of_regulator_get* functions allow using a
device node to get the regulator instead using the device object.

The first patch is not related to the second one, but it is little
improvement.

Gregory

Gregory CLEMENT (2):
  regulator: core: Add a sanity check on the regulator_ enable/disable
    functions
  regulator: core: Add the device tree version to the regulator_get
    family

 drivers/regulator/core.c           | 127 +++++++++++++++++++++++++++++++++----
 drivers/regulator/devres.c         |  70 ++++++++++++++++++--
 include/linux/regulator/consumer.h |  20 ++++++
 3 files changed, 198 insertions(+), 19 deletions(-)

-- 
1.9.1
