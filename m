From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
Date: Mon, 30 Jul 2018 08:15:47 -0700
Message-ID: <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com
Cc: rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Tejan,

On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
> Some minor fixes to be able to correctly set devslp register
> to optimize power.
> 
> Srinivas Pandruvada (2):
>   ata: libahci: Correct setting of DEVSLP register
>   ata: libahci: Allow reconfigure of DEVSLP register
> 
Are you applying this series?

Thanks,
Srinivas

>  drivers/ata/libahci.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
