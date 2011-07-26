From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] ata/ahci_platform: Add support for enabling/disabling
 clock.
Date: Tue, 26 Jul 2011 09:13:59 +0530
Message-ID: <4E2E37FF.4040606@st.com>
References: <211461c299bab630fda07f81963cab0b5f40c98d.1307609821.git.viresh.kumar@st.com> <4E08634F.3040902@st.com> <4E2B47AC.1010101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:44367 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751801Ab1GZDoM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jul 2011 23:44:12 -0400
In-Reply-To: <4E2B47AC.1010101@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>

On 07/24/2011 03:44 AM, Jeff Garzik wrote:
> Is it actually -used- somewhere?
> 
> It certainly looks straightforward...

Yes, this will be used for SPEAr1340. (Yet to add support for 1340 in mainline)

-- 
viresh
