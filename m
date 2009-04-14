From: Tejun Heo <tj@kernel.org>
Subject: Re: Problems with >3 drives on an eSATA portmultiplier
Date: Tue, 14 Apr 2009 19:45:05 +0900
Message-ID: <49E46931.9010105@kernel.org>
References: <Pine.LNX.4.63.0904011454020.3947@buttercup.gerph.org>  <da824cf30904010945i5a33f049v15745c79293d22ad@mail.gmail.com>  <Pine.LNX.4.63.0904011801160.3947@buttercup.gerph.org> <da824cf30904011046x46da9b69u28f00472a49ebc20@mail.gmail.com> <49D406BE.3080103@kernel.org> <Pine.LNX.4.63.0904032140500.3742@buttercup.gerph.org> <Pine.LNX.4.63.0904072219150.3742@buttercup.gerph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33222 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127AbZDNKph (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 06:45:37 -0400
In-Reply-To: <Pine.LNX.4.63.0904072219150.3742@buttercup.gerph.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Fletcher <gerph@gerph.org>
Cc: Grant Grundler <grundler@google.com>, linux-ide@vger.kernel.org

Hello,

Justin Fletcher wrote:
> For future reference if anyone else sees similar issues with their
> systems... I have replaced the bridge board with another and the problem
> has gone away - all 5 drives are accessible and I have no issues.
> 
> Thanks for the help, and sorry to have wasted your time.

Ah... thanks for reporting.  Was worried whether you discovered
yet-unknown 3726 detection problem.  :-)

-- 
tejun
