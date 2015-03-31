From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH 3/3] ahci: st: st_configure_oob must be called after IP
 is clocked.
Date: Tue, 31 Mar 2015 18:33:55 +0100
Message-ID: <20150331173355.GA15635@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
 <1427787309-1601-4-git-send-email-peter.griffin@linaro.org>
 <20150331152958.GF9974@htj.duckdns.org>
 <20150331153627.GA8200@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150331155951.GG9974@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33337 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbbCaReA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2015 13:34:00 -0400
Received: by wgoe14 with SMTP id e14so27097427wgo.0
        for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2015 10:33:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150331155951.GG9974@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org

Hi Tejun,

On Tue, 31 Mar 2015, Tejun Heo wrote:

> On Tue, Mar 31, 2015 at 04:36:27PM +0100, Peter Griffin wrote:
> > This patch (and also the DT documentation change) can go via your tree. Maxime
> > will take the stih407 DT patch.
> 
> Hmmm... The first patch doesn't apply to libata/for-4.1?

I was just investigating this, and you don't have the patch I sent on 25th February
entitled "ahci: st: Update the DT example for how to obtain the PHY."

I also did a re-send yesterday with ack's collected here https://lkml.org/lkml/2015/3/30/404.

However both times it seems I didn't add you to the email :-( which certainly explains
why you don't have it.

If I re-send that patch with you on CC can you take and apply it as well? That would
preserve the ack's.

regards,

Peter.
