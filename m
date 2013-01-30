From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ata: Fix DVD not dectected at some Haswell platforms
Date: Wed, 30 Jan 2013 16:26:01 +0400
Message-ID: <51091159.5080304@mvista.com>
References: <1359566374-27286-1-git-send-email-youquan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359566374-27286-1-git-send-email-youquan.song@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Youquan Song <youquan.song@intel.com>
Cc: htejun@gmail.com, ming.lei@canonical.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, seth.heasley@intel.com, jlee@suse.com, james.d.ralston@intel.com, Youquan Song <youquan.song@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

Hello.

On 30-01-2013 21:19, Youquan Song wrote:

> There is a quirk patch 5e5a4f5d5a08c9c504fe956391ac3dae2c66556d

   Please also specify the summary of that patch in parens.

> fix the 4 ports

    s/fix/fixing/

> IDE controller 32bit PIO mode.
> Recently, the problem was showed

    s/showed/shown/

> at Haswell platform which includes 2 ports IDE controller.

> So introduce a qurik

    Quirk.

> patch to disable 32bit PIO at this IDE controller.

    s/at/on/

> Signed-off-by: Youquan Song <youquan.song@intel.com>

MBR, Sergei
