From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: A question about NCQ
Date: Wed, 17 May 2006 10:21:10 +0800
Message-ID: <1147832470.7273.112.camel@forrest26.sh.intel.com>
References: <1147773689.7273.88.camel@forrest26.sh.intel.com>
	 <4469AE21.6000304@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-QdDcmGQxOM6P4FNhojV+"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:546 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751134AbWEQCc2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 22:32:28 -0400
In-Reply-To: <4469AE21.6000304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--=-QdDcmGQxOM6P4FNhojV+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-05-16 at 19:49 +0900, Tejun Heo wrote:
> I don't know the workload of iozone.  But NCQ shines when there are many
> concurrent IOs in progress.  A good real world example would be busy
> file-serving web server.  It generally helps if there are multiple IO
> requests.  If iozone is single-threaded (IO-wise), try to run multiple
> copies of them and compare the results.
> 
> Also, you need to pay attention to IO schedule in use, IIRC as and cfq
> are heavily optimized for single-queued devices and might not show the
> best performance depending on workload.  For functionality test, I
> usually use deadline.  It's simpler and usually doesn't get in the way,
> which, BTW, may or may not translate into better performance.
> 
Tejun,

I run iozone with 8 concurrent threads. From my understanding, NCQ
should at least provide the same throughput as non-NCQ. But the attached
test result showed that NCQ has the lower throughput compared with non-
NCQ.

The io scheduler is anticipatory.
The kernel without NCQ is 2.6.16-rc6, the kernel with NCQ is #upstream.

The current problem is that I don't know where the bottleneck is, block
I/O layer, SCSI layer, device driver layer or hardware problem......

Thanks,
Forrest

--=-QdDcmGQxOM6P4FNhojV+
Content-Disposition: attachment; filename=testresult.dio.8thread.NCQ
Content-Type: text/plain; name=testresult.dio.8thread.NCQ; charset=utf-8
Content-Transfer-Encoding: 7bit

	Iozone: Performance Test of File I/O
	        Version $Revision: 3.263 $
		Compiled for 32 bit mode.
		Build: linux 

	Contributors:William Norcott, Don Capps, Isom Crawford, Kirby Collins
	             Al Slater, Scott Rhine, Mike Wisner, Ken Goss
	             Steve Landherr, Brad Smith, Mark Kelly, Dr. Alain CYR,
	             Randy Dunlap, Mark Montague, Dan Million, 
	             Jean-Marc Zucconi, Jeff Blomberg,
	             Erik Habbinga, Kris Strecker, Walter Wong.

	Run began: Wed May 17 10:06:21 2006

	File size set to 2000 KB
	Record Size 1 KB
	O_DIRECT feature enabled
	Command line used: ./iozone -l 8 -u 8 -F hello1.data hello2.data hello3.data hello4.data hello5.data hello6.data hello7.data hello8.data -i 0 -s 2000 -r 1 -I
	Output is in Kbytes/sec
	Time Resolution = 0.000001 seconds.
	Processor cache size set to 1024 Kbytes.
	Processor cache line size set to 32 bytes.
	File stride size set to 17 * record size.
	Min process = 8 
	Max process = 8 
	Throughput test with 8 processes
	Each process writes a 2000 Kbyte file in 1 Kbyte records

	Children see throughput for  8 initial writers 	=    1862.25 KB/sec
	Parent sees throughput for  8 initial writers 	=     753.66 KB/sec
	Min throughput per process 			=       4.11 KB/sec 
	Max throughput per process 			=     588.33 KB/sec
	Avg throughput per process 			=     232.78 KB/sec
	Min xfer 					=      14.00 KB

	Children see throughput for  8 rewriters 	=    1582.49 KB/sec
	Parent sees throughput for  8 rewriters 	=    1576.26 KB/sec
	Min throughput per process 			=       2.49 KB/sec 
	Max throughput per process 			=     384.88 KB/sec
	Avg throughput per process 			=     197.81 KB/sec
	Min xfer 					=      13.00 KB



iozone test complete.

--=-QdDcmGQxOM6P4FNhojV+
Content-Disposition: attachment; filename=testresult.dio.8thread.nonNCQ
Content-Type: text/plain; name=testresult.dio.8thread.nonNCQ; charset=utf-8
Content-Transfer-Encoding: 7bit

	Iozone: Performance Test of File I/O
	        Version $Revision: 3.263 $
		Compiled for 32 bit mode.
		Build: linux 

	Contributors:William Norcott, Don Capps, Isom Crawford, Kirby Collins
	             Al Slater, Scott Rhine, Mike Wisner, Ken Goss
	             Steve Landherr, Brad Smith, Mark Kelly, Dr. Alain CYR,
	             Randy Dunlap, Mark Montague, Dan Million, 
	             Jean-Marc Zucconi, Jeff Blomberg,
	             Erik Habbinga, Kris Strecker, Walter Wong.

	Run began: Wed May 17 10:01:50 2006

	File size set to 2000 KB
	Record Size 1 KB
	O_DIRECT feature enabled
	Command line used: ./iozone -l 8 -u 8 -F hello1.data hello2.data hello3.data hello4.data hello5.data hello6.data hello7.data hello8.data -i 0 -s 2000 -r 1 -I
	Output is in Kbytes/sec
	Time Resolution = 0.000001 seconds.
	Processor cache size set to 1024 Kbytes.
	Processor cache line size set to 32 bytes.
	File stride size set to 17 * record size.
	Min process = 8 
	Max process = 8 
	Throughput test with 8 processes
	Each process writes a 2000 Kbyte file in 1 Kbyte records

	Children see throughput for  8 initial writers 	=    2263.96 KB/sec
	Parent sees throughput for  8 initial writers 	=     640.26 KB/sec
	Min throughput per process 			=       2.93 KB/sec 
	Max throughput per process 			=     985.75 KB/sec
	Avg throughput per process 			=     283.00 KB/sec
	Min xfer 					=       6.00 KB

	Children see throughput for  8 rewriters 	=    2656.53 KB/sec
	Parent sees throughput for  8 rewriters 	=    2602.82 KB/sec
	Min throughput per process 			=       3.80 KB/sec 
	Max throughput per process 			=    1923.40 KB/sec
	Avg throughput per process 			=     332.07 KB/sec
	Min xfer 					=       4.00 KB



iozone test complete.

--=-QdDcmGQxOM6P4FNhojV+--
