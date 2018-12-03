From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Sun, 02 Dec 2018 22:31:52 -0800 (PST)
Message-ID: <20181202.223152.888201577912576435.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


A missing of_node_put() and a small cleanup.

Please pull, thanks!

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 94d0fb159da94cb4522e14d6004bb7acf2ff0387:

  ide: Change to use DEFINE_SHOW_ATTRIBUTE macro (2018-12-02 22:09:09 -0800)

----------------------------------------------------------------
Yangtao Li (2):
      ide: pmac: add of_node_put()
      ide: Change to use DEFINE_SHOW_ATTRIBUTE macro

 drivers/ide/ide-proc.c | 15 ++-------------
 drivers/ide/pmac.c     |  1 +
 2 files changed, 3 insertions(+), 13 deletions(-)
