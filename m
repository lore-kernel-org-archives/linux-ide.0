From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH] ata: ahci_st: fixup layering violations / drvdata errors
Date: Thu, 9 Apr 2015 10:43:10 +0100
Message-ID: <20150409094310.GA29026@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1428519599-31885-1-git-send-email-computersforpeace@gmail.com>
 <552627BD.9060109@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <552627BD.9060109@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kernel@stlinux.com, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Patrice Chotard <patrice.chotard@st.com>
List-Id: linux-ide@vger.kernel.org

Hi Maxime,

On Thu, 09 Apr 2015, Maxime Coquelin wrote:
> Hello Brian,
> 
<snip>
> >  drivers/ata/ahci_st.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> >
> 
> Your patch looks sensible, thanks for spotting this issue.
> 
> Peter, do you have the SATA setup in place to test Brian's patch?

Yes I can test, although not until Saturday as I only have remote
access to the board today & tomorrow and the hard drive isn't
plugged in.

regards,

Peter.
