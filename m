From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [PATCH 3.6.0- 0/2] IDE: use module_platform_driver macro
Date: Wed, 10 Oct 2012 19:33:05 +0100
Message-ID: <1349893985-7883-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:48074 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754149Ab2JJSfN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2012 14:35:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: srinivas.kandagatla@st.com, bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, galak@kernel.crashing.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Running below Coccinelle lookup pattern like below on the 
latest kernel showed about 52 hits. This patch series is a subset 
of those 52 patches, so that it will be easy for maintainers to review.
Hopefully these patches will get rid of some code duplication in kernel.

@  @
- initfunc(void)
- { return platform_driver_register(&dr); }

...

- module_init(initfunc);
...

- exitfunc(void)
- { platform_driver_unregister(&dr); }

...

- module_exit(exitfunc);
+ module_platform_driver(dr); 


Srinivas Kandagatla (2):
  ide/au1xxx: use module_platform_driver macro
  ide_platform: use module_platform_driver macro

 drivers/ide/au1xxx-ide.c   |   14 +-------------
 drivers/ide/ide_platform.c |   14 +-------------
 2 files changed, 2 insertions(+), 26 deletions(-)

