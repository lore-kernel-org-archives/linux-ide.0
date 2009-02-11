From: Tejun Heo <tj@kernel.org>
Subject: Re: Processes dying with ENXIO or EINTR - disk related?
Date: Wed, 11 Feb 2009 10:29:03 +0900
Message-ID: <499229DF.50708@kernel.org>
References: <b895fb7dff47e49eee46d6bfc66b06e6.squirrel@www.datavault.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33410 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547AbZBKB25 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Feb 2009 20:28:57 -0500
In-Reply-To: <b895fb7dff47e49eee46d6bfc66b06e6.squirrel@www.datavault.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: linux-ide@vger.kernel.org

Yan Seiner wrote:
> Recently I've started getting system freezeups and weird segfaults with
> EINTR (Interrupted system call) and ENXIO (No such device or address).
> 
> These errors can be in ld, libc, and so on.  I'm stumped; the system has
> worked fine for quite a while and just recently has developed this
> behavior.  I can start yanking out hardware, but before I do that I wonder
> if it is something to do with disk access.  I'm a bit stumped as to what
> else could cause ENXIO on loading an app....  Needless to say there aren't
> any errors at all anywhere that I can find, so I am guessing.

Highly unlikely it's related to IO.

> Any suggestions on where to look?
> 
> [15311.303130] kaffeine[17432]: segfault at 7f7de5d291b8 ip
> 00007f7de81d0216 sp 00007ffff03de9d0 error 6 in
> ld-2.7.so[7f7de81c5000+1c000]
> [15312.043891] kaffeine[17462]: segfault at 7f2fab2cd1b8 ip
> 00007f2fad774216 sp 00007fffb5984f70 error 6 in
> ld-2.7.so[7f2fad769000+1c000]
> [15476.877225] kaffeine[18189]: segfault at 7fe3453e31b8 ip
> 00007fe34788a216 sp 00007fff4fa9b080 error 6 in
> ld-2.7.so[7fe34787f000+1c000]
> [15478.873424] kaffeine[18202]: segfault at 7f671c7d51b8 ip
> 00007f671ec7c216 sp 00007fff26e8b470 error 6 in
> ld-2.7.so[7f671ec71000+1c000]
> [15479.998904] kaffeine[18204]: segfault at 7f298ec591b8 ip
> 00007f2991100216 sp 00007fff993107c0 error 6 in
> ld-2.7.so[7f29910f5000+1c000]
> [15524.139436] kaffeine[18355]: segfault at 7f61f74db1b8 ip
> 00007f61f9982216 sp 00007fff01b93180 error 6 in
> ld-2.7.so[7f61f9977000+1c000]
> [15536.953603] kaffeine[18438]: segfault at 7f712c6281b8 ip
> 00007f712eacf216 sp 00007fff36cde2c0 error 6 in
> ld-2.7.so[7f712eac4000+1c000]
> [15540.212381] kaffeine[18473]: segfault at 7f193951d1b8 ip
> 00007f193b9c4216 sp 00007fff43bd51c0 error 6 in
> ld-2.7.so[7f193b9b9000+1c000]
> [15541.013250] kaffeine[18475]: segfault at 7f40e7a201b8 ip
> 00007f40e9ec7216 sp 00007ffff20d56c0 error 6 in
> ld-2.7.so[7f40e9ebc000+1c000]
> [16888.677962] mythbackend[24148]: segfault at 7f05edf0a1b8 ip
> 00007f05ef073216 sp 00007ffff72839c0 error 6 in
> ld-2.7.so[7f05ef068000+1c000]

Bad memory?

-- 
tejun
