From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/9] ide: add ->tf_load and ->tf_read methods
Date: Wed, 16 Apr 2008 22:12:50 +0400
Message-ID: <480641A2.1080004@ru.mvista.com>
References: <20080412123401.18751.17246.sendpatchset@localhost.localdomain> <20080412123415.18751.51136.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753709AbYDPSNl@vger.kernel.org>
In-Reply-To: <20080412123415.18751.51136.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add ->tf_load and ->tf_read methods to ide_hwif_t and set the default
>   methods in default_hwif_transport().

    It's not clear to me what do we gain with addign such methods...

> * Use ->tf_{load,read} instead o calling ide_tf_{load,read}() directly.

> * Make ide_tf_{load,read}() static.

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
