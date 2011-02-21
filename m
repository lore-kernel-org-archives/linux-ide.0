From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2 2/2] pata_arasan_cf: Adding support for arasan
 compact flash host controller
Date: Mon, 21 Feb 2011 09:31:55 +0100
Message-ID: <20110221083155.GB31267@htj.dyndns.org>
References: <cover.1298029161.git.viresh.kumar@st.com>
 <e2f140271f9db752fdc05e348065b23fc4e4aa29.1298029161.git.viresh.kumar@st.com>
 <20110218143438.GK21209@htj.dyndns.org>
 <AANLkTi=bK54_OEFh=Fhx9N8TxVcFxUFYJm8XS=MKZdG2@mail.gmail.com>
 <20110218172052.GT21209@htj.dyndns.org>
 <AANLkTin09CMbcTsQZUV9cwA2tbhr1L6J+BLguTeGMe+9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46590 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773Ab1BUIcA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Feb 2011 03:32:00 -0500
Received: by fxm17 with SMTP id 17so1219289fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 21 Feb 2011 00:31:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTin09CMbcTsQZUV9cwA2tbhr1L6J+BLguTeGMe+9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.linux@gmail.com>
Cc: Viresh Kumar <viresh.kumar@st.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, shiraz.hashim@st.com, armando.visconti@st.com, amit.goel@st.com

Hello,

On Sat, Feb 19, 2011 at 09:09:54AM +0530, viresh kumar wrote:
> I haven't done any such testing yet. What should i call for fake
> failures from interrupt handler. freeze()?? or As i am doing in
> dma_xfer for real failures?

Yeap, what the driver would do on actual failures and making sure
things actually work as expected.

Thanks.

-- 
tejun
