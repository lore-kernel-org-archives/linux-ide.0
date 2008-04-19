From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] siimage: do clocking register posting earlier in
 setup_mmio_siimage()
Date: Sat, 19 Apr 2008 20:48:16 +0400
Message-ID: <480A2250.20201@ru.mvista.com>
References: <200804092051.01552.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756621AbYDSQtQ@vger.kernel.org>
In-Reply-To: <200804092051.01552.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Do clocking register posting earlier in setup_mmio_siimage()
> to match code in init_chipset_siimage().

> This is a preparation for the next patch which merges PCI and MMIO
> code paths together.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
