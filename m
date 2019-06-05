From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: libata: sysctl knob for enabling tpm/opal at runtime
Date: Wed,  5 Jun 2019 13:36:25 +0200
Message-ID: <1559734587-32596-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello folks,


here's a patchset that allows enabling libata's tpm features (opal)
at runtime. Until now we need to boot with special kernel parameter,
in order to use OPAL - this patch also adds a sysctl knob for that.

It seems such a knob already had existed once (perhaps just in an
wip patchset), as sed-util expects it.

The first patch just introduces a systcl subdir for libata, the
second one adds the actual knob. I had already sent these patches,
few weeks ago, along with some general build fixes. The latter
meanwhile went mainline, but haven't received any comments on
the two opal related ones yet.

Please let me know, whether there's anything wrong w/ it.


have fun,
--mtx
