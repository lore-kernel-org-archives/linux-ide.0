From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 0/4] R-Car SATA driver and platform data
Date: Sun, 17 Feb 2013 01:35:27 +0300
Message-ID: <201302170135.28336.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: horms@verge.net.au, magnus.damm@gmail.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org
List-Id: linux-ide@vger.kernel.org

Hello.

   Here's the set of 4 patches against the Simon Horman's renesas.git repo, 'next' branch:

[1/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
[2/4] ARM: mach-shmobile: r8a7779: add SATA support
[3/4] libata: add R-Car SATA driver
[4/4] ARM: mach-shmobile: marzen: add SATA support

Patch 3 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git repo.

MBR, Sergei
