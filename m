From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Performance issue with port multiplier
Date: Tue, 13 May 2014 23:40:31 -0400
Message-ID: <5372E5AF.9020708@ubuntu.com>
References: <53587A1A.2060904@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:46245 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752726AbaENDre (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 May 2014 23:47:34 -0400
In-Reply-To: <53587A1A.2060904@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 04/23/2014 10:42 PM, Phillip Susi wrote:
> I recently picked up a Thermaltake BlacX Duet dual drive esata dock
> and I am having some performance problems trying to use both drives
> concurrently.  The link is running at 3 Gbps both to the PMP and from
> there to each drive.  An individual drive pulls ~175 MB/s, but trying
> to use both drops to ~60 MB/s each.  This is with a simple sequential
> dd to /dev/null with a 1 MiB block size.  Oddly, disabling NCQ results
> in an increase to ~80 MB/s per drive.  I wouldn't think that NCQ would
> really help for a sequential read, but it certainly shouldn't hurt.
> 
> Now it does seem that my intel ahci chipset does not support fis based
> switching, but it doesn't seem like that should make a whole lot of
> difference for sequential IO since while you are busy sending commands
> to one drive, the other should still be performing its own readahead
> into its cache and be ready to satisfy the request quickly once the
> first drive finishes.
> 
> How can this behavior make sense?  Any ideas on other things I could try?

So I would have thought that if you asked a disk drive with 64 mb of
cache to read a few mb, then waited a second before issuing more
commands, it would continue to read the next several mb into cache while
waiting for new commands.  I wrote a simple benchmark to test this by
reading 16 256k blocks ( with O_DIRECT from a random starting offset to
start with cold cache ), sleeping for 1 second, then reading the next
16, and the results seem to show that the drive stops reading ahead just
after 1 MB.  Do drives really have such terrible readahead algorithms in
general?  If so, this would seem to explain the terrible port multiplier
performance in the absence of FBS.  If this is really the norm, then
perhaps libata needs to do a better job of balancing requests between
the drives?

My test results:

read took 6598 us
read took 1157 us
read took 1207 us
read took 1178 us
read took 1187 us
read took 2373 us << odd delay
read took 1172 us
read took 1180 us
read took 1163 us
read took 1171 us
read took 1172 us
read took 1136 us
read took 2373 us
read took 1129 us
read took 1170 us
read took 1171 us
- ---
read took 636 us
read took 628 us
read took 625 us
read took 627 us
read took 626 us
read took 626 us
read took 580 us
read took 563 us
read took 6733 us << why is this even longer than the first seek
read took 1237 us << cache is now empty, waiting on actual reads
read took 2326 us << odd delay
read took 1165 us
read took 1169 us
read took 1171 us
read took 1173 us
read took 1169 us
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJTcuWsAAoJEI5FoCIzSKrwMEEH/03Qne3kWo3UdW62OZVTcD0Z
DgCtOSIx//feHDgXOIu46f8QO6BnvAFG+RyrplVjMvNTKio4M4cgCHJU7EOUaka0
tN2eturZFnzCo5ZQLgaQ8ZWWihbxVdT9BVjt0ixn+lUNjbhLfLf+qvagzOeLenOa
RtMV2RbywK/G0DTEurNocQgJq/bVtoAtHGwv24WADL4ITd+5oRQHqBB5JupnUCD7
Nr8/uwLKkJZ7aVAX0zYAvFIUu3O0AucX/fPl8W63rm3wuB+E8BlLpHkMoF9hV8g0
qJiobIvUnbJ3y8luRlZjO5uH39osGfhFWH4r+cBDnI8eFoxdfcigyk3KEMeI48w=
=ROo0
-----END PGP SIGNATURE-----
