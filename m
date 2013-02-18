From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2 0/4] R-Car SATA driver and platform data
Date: Mon, 18 Feb 2013 23:27:46 +0300
Message-ID: <201302182327.46930.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: horms@verge.net.au, magnus.damm@gmail.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, vladimir.barinov@cogentembedded.com
List-Id: linux-ide@vger.kernel.org

Hello.

   Here's the v2 of the set of 4 patches against the Simon Horman's renesas.git
repo, 'next' branch:

[1/4] libata: add R-Car SATA driver
[2/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
[3/4] ARM: mach-shmobile: r8a7779: add SATA support
[4/4] ARM: mach-shmobile: marzen: add SATA support

Patch 1 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git
repo.

Patch changes since the initial posting are reported in the individual patches.

MBR, Sergei
