From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: libata fixes for NVME + OPAL
Date: Wed, 24 Apr 2019 12:34:38 +0200
Message-ID: <1556102081-11820-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hello folks,


here're some fixes for libata to make NVME and TCG OPAL work:

* fix a little build break in nvme (forgotten include and Kconfig select)
* introduce sysctl knob for enabling tpm stuff at runtime
  (sed-util expects since several years, so it seems that piece just might
  have been forgotten when opal support was mainlined)


--mtx
