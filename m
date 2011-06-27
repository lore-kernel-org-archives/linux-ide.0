From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] ata/ahci_platform: Add support for enabling/disabling
 clock.
Date: Mon, 27 Jun 2011 16:32:39 +0530
Message-ID: <4E08634F.3040902@st.com>
References: <211461c299bab630fda07f81963cab0b5f40c98d.1307609821.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:51123 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755041Ab1F0LCy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2011 07:02:54 -0400
In-Reply-To: <211461c299bab630fda07f81963cab0b5f40c98d.1307609821.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "jgarzik@pobox.com" <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>

On 06/09/2011 02:28 PM, Viresh KUMAR wrote:
> On many architectures, drivers are supposed to enable/disable functional clock
> of device. This patch adds support for clock enabling/disabling in
> ahci_platform.c.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/ata/ahci.h          |    4 ++++
>  drivers/ata/ahci_platform.c |   36 +++++++++++++++++++++++++++++++-----
>  2 files changed, 35 insertions(+), 5 deletions(-)
> 

Hi Jeff,

Any inputs on this patch?

-- 
viresh
