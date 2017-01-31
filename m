From: Tejun Heo <tj@kernel.org>
Subject: Re: for-4.10-fixes branch
Date: Tue, 31 Jan 2017 11:35:39 -0500
Message-ID: <20170131163539.GA23970@htj.duckdns.org>
References: <ccee6286-f349-5f2e-0e6e-39496bc3f986@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33762 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbdAaSix (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2017 13:38:53 -0500
Received: by mail-pf0-f179.google.com with SMTP id y143so109659790pfb.0
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2017 10:38:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ccee6286-f349-5f2e-0e6e-39496bc3f986@wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Tue, Jan 31, 2017 at 11:47:36AM +0900, Damien Le Moal wrote:
> Tejun,
> 
> Some commits in your for-4.10-fixes branch have not yet been pulled in
> Linus 4.10 tree. Is this normal ? Can we expect the fixes to go in rc7 ?
> I am concerned about the request sense fix I sent. That bug is breaking
> applications and still exists in rc6. Those commits really need to go in.

That's me waiting for more fixes combined with procrastinating.  Will
send the trees out right away.

Thanks for the poking.

-- 
tejun
