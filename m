From: Justin Fletcher <gerph@gerph.org>
Subject: Re: Problems with >3 drives on an eSATA portmultiplier
Date: Tue, 7 Apr 2009 22:20:47 +0100 (BST)
Message-ID: <Pine.LNX.4.63.0904072219150.3742@buttercup.gerph.org>
References: <Pine.LNX.4.63.0904011454020.3947@buttercup.gerph.org>
 <da824cf30904010945i5a33f049v15745c79293d22ad@mail.gmail.com>
 <Pine.LNX.4.63.0904011801160.3947@buttercup.gerph.org>
 <da824cf30904011046x46da9b69u28f00472a49ebc20@mail.gmail.com>
 <49D406BE.3080103@kernel.org> <Pine.LNX.4.63.0904032140500.3742@buttercup.gerph.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:58166 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbZDGVU4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 17:20:56 -0400
In-Reply-To: <Pine.LNX.4.63.0904032140500.3742@buttercup.gerph.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Grant Grundler <grundler@google.com>, linux-ide@vger.kernel.org

On Fri, 3 Apr 2009, Justin Fletcher wrote:

> On Thu, 2 Apr 2009, Tejun Heo wrote:
>
>> Grant Grundler wrote:
>>>> I could drop down to 2.6.26 and rebuild my kernel with support for that
>>>> controller - I hadn't done this before because I cannot then use my DVB-S
>>>> card, but... I could live without that for the test.
>>> 
>>> If someone could comment on  2.6.28 or 2.6.29, you could avoid running
>>> this test.
>> 
>> Hmmm... I don't really remember changing much, so it should be fine.
>> Can you please give a shot at 2.6.26 anyway?  Also, kernel logs with
>> JMB controller would be helpful too as ahci tends to better show what's
>> really going on and failing during reset.

For future reference if anyone else sees similar issues with their 
systems... I have replaced the bridge board with another and the problem 
has gone away - all 5 drives are accessible and I have no issues.

Thanks for the help, and sorry to have wasted your time.

-- 
Gerph <http://gerph.org/>
[ All information, speculation, opinion or data within, or attached to,
   this email is private and confidential. Such content may not be
   disclosed to third parties, or a public forum, without explicit
   permission being granted. ]
